class SitemapController < ApplicationController

	def index
		path = Rails.root.join("public", "sitemap.xml")
		if File.exists?(path)
      render xml: open(path).read
    else
      render text: "Sitemap not found.", status: :not_found
    end
	end
end
