return {
  {
    pattern = "/lib/tasks/([^/]*).rake",
    target = "/spec/lib/tasks/%1_spec.rb"
  },
  {
    pattern = "/spec/lib/tasks/([^/]*)_spec.rb",
    target = "/lib/tasks/%1.rake"
  },
  {
    pattern = "/lib/([^/]*).rb",
    target = "/spec/lib/%1_spec.rb"
  },
  {
    pattern = "/spec/lib/([^/]*)_spec.rb",
    target = "/lib/%1.rb"
  },
  {
    pattern = "/lib/([^/]*)/([^/]*).rb",
    target = "/spec/lib/%1/%2_spec.rb"
  },
  {
    pattern = "/spec/lib/([^/]*)/([^/]*)_spec.rb",
    target = "/lib/%1/%2.rb"
  },
  {
    pattern = "/lib/([^/]*)/([^/]*)/([^/]*).rb",
    target = "/spec/lib/%1/%2/%3_spec.rb"
  },
  {
    pattern = "/spec/lib/([^/]*)/([^/]*)/([^/]*)_spec.rb",
    target = "/lib/%1/%2/%3.rb"
  },
  {
    pattern = "/app/([^/]*)/([^/]*).rb",
    target = "/spec/%1/%2_spec.rb"
  },
  {
    pattern = "/spec/([^/]*)/([^/]*)_spec.rb",
    target = "/app/%1/%2.rb"
  },

  {
    pattern = "/app/([^/]*)/([^/]*)/([^/]*).rb",
    target = "/spec/%1/%2/%3_spec.rb"
  },
  {
    pattern = "/spec/([^/]*)/([^/]*)/([^/]*)_spec.rb",
    target = {
      {
        target = "/app/%1/%2/%3.rb",
        context = "app"
      },
      {
        target = "/%1/%2/%3.rake",
        context = "tasks"
      }
    }
  },
  {
    pattern = "/app/([^/]*)/([^/]*)/([^/]*)/([^/]*).rb",
    target = "/spec/%1/%2/%3/%4_spec.rb"
  },
  {
    pattern = "/spec/([^/]*)/([^/]*)/([^/]*)/([^/]*)_spec.rb",
    target = "/app/%1/%2/%3/%4.rb"
  },
  {
    pattern = "/app/views/(.*)/(.*)",
    target = "/spec/views/%1/%2_spec.rb",
  },
  {
    pattern = "/spec/views/(.*)/(.*)_spec.rb",
    target = "/app/views/%1/%2",
  }
}
