require 'net/http'

helpers do
  def bdash_version
    return config[:bdash_version] if config[:bdash_version]

    url = URI.parse('https://github.com/bdash-app/bdash/releases/latest')
    http = Net::HTTP.new(url.host, url.port).tap {|h| h.use_ssl = true }
    res = http.start { http.get(url.path) }
    location = res['location']
    raise 'Invalid response' unless location

    config[:bdash_version] = res['location'].strip.slice(/\d+\.\d+\.\d+\z/)
    raise 'Invalid version' unless config[:bdash_version]

    config[:bdash_version]
  end

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
    "https://bdash.global.ssl.fastly.net/v#{bdash_version}/#{download_file_name_for(platform)}"
  end

  def download_file_name_for(platform)
    case platform
    when :mac
      "Bdash-#{bdash_version}.dmg"
    when :windows
      "Bdash+Setup+#{bdash_version}.exe"
    when :linux
      "Bdash-#{bdash_version}-x86_64.AppImage"
    else
      raise ArgumentError, "Invalid platform: #{platform}"
    end
  end
end
