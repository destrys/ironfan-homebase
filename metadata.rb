maintainer       "Mike Heffner, Librato, Inc."
maintainer_email "mike@librato.com"
license          "Apache 2.0"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "3.0.0"

description      "Installs/Configures Sys Logging to papertrailapp.com"

depends          "rsyslog"

recipe           "papertrail::default",                "Base configuration for papertrail"

%w[ debian ubuntu ].each do |os|
  supports os
end

attribute "papertrail/logger",
  :display_name          => "Logger to use. Support loggers include: rsyslog. Defaults to rsyslog.",
  :description           => "",
  :default               => "rsyslog"

attribute "papertrail/remote_host",
  :display_name          => "Papertrail host to send stats to. Defaults to `logs.papertrailapp.com`.",
  :description           => "",
  :default               => "logs.papertrailapp.com"

attribute "papertrail/remote_port",
  :display_name          => "Port to use. No default.",
  :description           => "",
  :default               => ""

attribute "papertrail/cert_file",
  :display_name          => "Location of papertrail certificate file",
  :description           => "",
  :default               => "/etc/papertrail.crt"

attribute "papertrail/cert_url",
  :display_name          => "URL to download certificate from",
  :description           => "",
  :default               => "https://papertrailapp.com/tools/syslog.papertrail.crt"

attribute "papertrail/hostname_name",
  :display_name          => "Explicit override of system's hostname",
  :description           => %Q{By default, this recipe will log to Papertrail using the system\'s hostname. If you want to set the hostname that will be used (think ephemeral cloud nodes) you can set `hostname_name` (preferred) or `hostname_cmd` (used if `hostname_name` is absent).},
  :default               => ""

attribute "papertrail/hostname_cmd",
  :display_name          => "Command to run to determine system's hostname",
  :description           => %Q{By default, this recipe will log to Papertrail using the system\'s hostname. If you want to set the hostname that will be used (think ephemeral cloud nodes) you can set `hostname_name` (preferred) or `hostname_cmd` (used if `hostname_name` is absent).},
  :default               => ""

attribute "papertrail/watch_files",
  :display_name          => "Command to run to determine system's hostname",
  :description           => %Q{A list of files that will be to watch and include in the papertrail logging -- useful for including output from applications that aren\'t configured to use syslog.

Each entry in this list is a hash of:
* [:filename] - Full path to the file.
* [:tag] - What to tag log lines that come from this file. Best to use a short application name.

For example:
  default[:papertrail][:watch_files] = [{:filename => "/var/log/myapp.log", :tag => "myapp:"}]
},
  :default => ""
