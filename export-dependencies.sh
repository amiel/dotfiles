#!/usr/bin/env bash
#
# export - Interactive TUI to generate an install script from currently installed software
#
# This script uses gum (https://github.com/charmbracelet/gum) to provide a nice
# terminal UI for selecting which Homebrew formulae, casks, and Mac App Store
# apps should be included in the install script.
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_FILE="$SCRIPT_DIR/install"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}▶${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

# Check for required dependencies
check_dependencies() {
  if ! command -v brew &> /dev/null; then
    error "Homebrew is not installed. Please install it first."
    exit 1
  fi

  if ! command -v gum &> /dev/null; then
    warn "gum is not installed. Installing via Homebrew..."
    brew install gum
  fi

  if ! command -v mas &> /dev/null; then
    warn "mas is not installed. Installing via Homebrew..."
    brew install mas
  fi
}

# Extract currently selected items from install script (for re-runs)
get_current_selections() {
  local start_marker="$1"
  local end_marker="$2"
  local pattern="$3"

  if [ ! -f "$INSTALL_FILE" ] || [ ! -s "$INSTALL_FILE" ]; then
    return
  fi

  sed -n "/$start_marker/,/$end_marker/p" "$INSTALL_FILE" | \
    grep -E "$pattern" | \
    sed -E 's/.*install (--cask )?([^ ]+).*/\2/' | \
    sed 's/ 2>.*//'
}

# Get top-level formulae (not dependencies)
get_installed_formulae() {
  brew leaves 2>/dev/null | sort
}

# Get installed casks
get_installed_casks() {
  brew list --cask 2>/dev/null | sort
}

# Get installed Mac App Store apps
get_installed_mas() {
  mas list 2>/dev/null | while read -r line; do
    id=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | sed 's/^[0-9]* *//' | sed 's/ *([^)]*) *$//')
    echo "$id|$name"
  done
}

# Interactive selection using gum
select_items() {
  local title="$1"
  local items="$2"
  local preselected="$3"

  if [ -z "$items" ]; then
    return
  fi

  # Build the gum choose arguments
  local args=()
  while IFS= read -r item; do
    [ -z "$item" ] && continue
    args+=("$item")
  done <<< "$items"

  if [ ${#args[@]} -eq 0 ]; then
    return
  fi

  # Build preselected arguments
  local selected_args=()
  while IFS= read -r sel; do
    [ -z "$sel" ] && continue
    for arg in "${args[@]}"; do
      if [[ "$arg" == "$sel" ]] || [[ "$arg" == *"|$sel"* ]] || [[ "$arg" == "$sel|"* ]]; then
        selected_args+=("--selected=$arg")
        break
      fi
    done
  done <<< "$preselected"

  echo "" >&2
  gum style --foreground 212 --bold "$title" >&2
  echo "" >&2

  # Run gum choose with multi-select
  gum choose --no-limit --height=20 "${selected_args[@]}" "${args[@]}"
}

# Generate the complete install script
generate_install_script() {
  local formulae_content="$1"
  local casks_content="$2"
  local mas_content="$3"

  cat <<'HEADER'
#!/usr/bin/env bash
#
# install - Set up a new Mac with Homebrew packages, casks, and Mac App Store apps
#
# Usage: ./install/install
#

set -e

echo "Installing software..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

HEADER

  echo "### BEGIN FORMULAE ###"
  printf "%s" "$formulae_content"
  echo "### END FORMULAE ###"
  echo ""

  echo "### BEGIN CASKS ###"
  printf "%s" "$casks_content"
  echo "### END CASKS ###"
  echo ""

  echo "### BEGIN MAS ###"
  printf "%s" "$mas_content"
  echo "### END MAS ###"
  echo ""

  cat <<'FOOTER'
brew cleanup

echo "Done!"
FOOTER
}

# Main function
main() {
  info "Dotfiles Export Tool"
  echo "This tool generates install/install from your currently installed software."
  echo ""

  check_dependencies

  # Get current selections from install file (supports re-running)
  info "Reading current install configuration..."
  current_formulae=$(get_current_selections "BEGIN FORMULAE" "END FORMULAE" "^brew install [^-]")
  current_casks=$(get_current_selections "BEGIN CASKS" "END CASKS" "brew install --cask")
  current_mas=$(get_current_selections "BEGIN MAS" "END MAS" "^mas install")

  # Get installed software
  info "Discovering installed software..."

  installed_formulae=$(get_installed_formulae)
  installed_casks=$(get_installed_casks)
  installed_mas=$(get_installed_mas)

  formulae_count=$(echo "$installed_formulae" | grep -c . || echo 0)
  casks_count=$(echo "$installed_casks" | grep -c . || echo 0)
  mas_count=$(echo "$installed_mas" | grep -c . || echo 0)

  success "Found $formulae_count top-level formulae, $casks_count casks, $mas_count MAS apps"
  echo ""

  # Confirm to proceed
  if ! gum confirm "Continue with selection?"; then
    info "Cancelled."
    exit 0
  fi

  # Select formulae
  selected_formulae=$(select_items "Select Homebrew Formulae (top-level only, no dependencies)" "$installed_formulae" "$current_formulae")

  # Select casks
  selected_casks=$(select_items "Select Homebrew Casks" "$installed_casks" "$current_casks")

  # Select MAS apps
  selected_mas=$(select_items "Select Mac App Store Apps" "$installed_mas" "$current_mas")

  echo ""
  info "Generating install script content..."

  # Generate formulae content
  formulae_content=""
  while IFS= read -r formula; do
    [ -z "$formula" ] && continue
    formulae_content+="brew install $formula"$'\n'
  done <<< "$selected_formulae"

  # Generate casks content
  casks_content=""
  while IFS= read -r cask; do
    [ -z "$cask" ] && continue
    casks_content+="brew install --cask $cask 2> /dev/null"$'\n'
  done <<< "$selected_casks"

  # Generate MAS content
  mas_content=""
  while IFS= read -r mas_item; do
    [ -z "$mas_item" ] && continue
    id=$(echo "$mas_item" | cut -d'|' -f1)
    name=$(echo "$mas_item" | cut -d'|' -f2)
    mas_content+="mas install $id # $name"$'\n'
  done <<< "$selected_mas"

  # Show summary
  echo ""
  gum style --foreground 212 --bold "Summary:"
  echo ""

  echo "Formulae to install:"
  if [ -n "$selected_formulae" ]; then
    echo "$selected_formulae" | sed 's/^/  /'
  else
    echo "  (none)"
  fi
  echo ""

  echo "Casks to install:"
  if [ -n "$selected_casks" ]; then
    echo "$selected_casks" | sed 's/^/  /'
  else
    echo "  (none)"
  fi
  echo ""

  echo "Mac App Store apps to install:"
  if [ -n "$selected_mas" ]; then
    echo "$selected_mas" | sed 's/|/ - /' | sed 's/^/  /'
  else
    echo "  (none)"
  fi
  echo ""

  # Confirm to write
  if ! gum confirm "Write install script to $INSTALL_FILE?"; then
    info "Cancelled. No changes made."
    exit 0
  fi

  # Generate and write the install script
  info "Writing $INSTALL_FILE..."
  generate_install_script "$formulae_content" "$casks_content" "$mas_content" > "$INSTALL_FILE"
  chmod +x "$INSTALL_FILE"

  success "Install script created successfully!"
  echo ""
  info "Review with: cat install"
  info "Run with: ./install"
}

main "$@"
