require 'rack'

class PersonalSite
  def self.call(env)
    case env['PATH_INFO']
    when '/' then index
    when '/about' then about
    when '/blog' then blog
    else check_assets(env['PATH_INFO'])
    end
  end

  def self.check_assets(path)
    if File.exist?("./public/#{path}")
      render_static(path)
    else
      error
    end
  end

  def self.render_view(page, code = '200')
    [code,
     { 'Content-Type' => 'text/html' },
     [File.read("./app/views/#{page}")]]
  end

  def self.render_static(asset)
    [200,
     { 'Content-Type' => 'text/html' },
     [File.read("./public/#{asset}")]]
  end

  def self.blog
    render_view('blog.html')
  end

  def self.index
    render_view('index.html')
  end

  def self.about
    render_view('about.html')
  end

  def self.error
    render_view('error.html', '404')
  end
end
