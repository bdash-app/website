set :layout, false

config[:bdash_version] = `curl -s -I https://github.com/bdash-app/bdash/releases/latest | grep 'Location:'`.strip.slice(/[\d.]+\z/)
