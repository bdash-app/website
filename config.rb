set :layout, false

config[:bdash_version] = `curl -s -I https://github.com/bdash-app/bdash/releases/latest | grep 'Location:'`.strip.slice(/\d+\.\d+\.\d+\z/)
raise 'Invalid version' unless /\A\d+\.\d+\.\d+\z/ === config[:bdash_version]

helpers do
  def platform_label_for(platform)
    case platform
    when :mac
      "macOS"
    when :windows
      "Windows"
    when :linux
      "Linux"
    else
      raise ArgumentError, "Invalid platform: #{platform}"
    end
  end

  def download_url_for(platform)
    "https://github.com/bdash-app/bdash/releases/download/v#{bdash_version}/#{download_file_name_for(platform)}"
  end

  def download_file_name_for(platform)
    case platform
    when :mac
      "Bdash-#{bdash_version}.dmg"
    when :windows
      "Bdash-Setup-#{bdash_version}.exe"
    when :linux
      "Bdash-#{bdash_version}-x86_64.AppImage"
    else
      raise ArgumentError, "Invalid platform: #{platform}"
    end
  end

  def bdash_version
    config[:bdash_version]
  end
end
