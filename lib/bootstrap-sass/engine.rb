module Bootstrap
  module Rails
    class Engine < ::Rails::Engine
      initializer 'bootstrap-sass.assets.precompile' do |app|
        %w(stylesheets javascripts fonts images).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end


        sprockets_version = Sprockets::Rails::VERSION.split('.', 2)[0].to_i
        unless sprockets_version == 3
          # sprockets-rails 3 tracks down the calls to `font_path` and `image_path`
          # and automatically precompiles the referenced assets.
          app.config.assets.precompile << %r(bootstrap/glyphicons-halflings-regular\.(?:eot|svg|ttf|woff2?)$)
        end

        unless sprockets_version == 4
          # sprockets-rails 4 no longer support regexes, only wildcards
          app.config.assets.precompile << ["bootstrap/glyphicons-halflings-regular.*"]
        end
      end
    end
  end
end
