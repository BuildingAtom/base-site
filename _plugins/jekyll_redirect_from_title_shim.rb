# Modify the JekyllRedirectFrom redirect page to merge original page data

module JekyllRedirectFrom
  class RedirectPage < Jekyll::Page

    # Creates a new RedirectPage instance from a source path and redirect path
    #
    # site - The Site object
    # page_source - The Page object of the source
    # from - the (URL) path, relative to the site root to redirect from
    # to   - the relative path or URL which the page should redirect to
    def self.from_paths(site, page_source, from, to)
      page = RedirectPage.new(site, site.source, "", "redirect.html")
      page.data["source"] = page_source.data
      page.set_paths(from, to)
      page
    end

    # Creates a new RedirectPage instance from the path to the given doc
    def self.redirect_from(doc, path)
      RedirectPage.from_paths(doc.site, doc, path, doc.url)
    end

    # Creates a new RedirectPage instance from the doc to the given path
    def self.redirect_to(doc, path)
      RedirectPage.from_paths(doc.site, doc, doc.url, path)
    end
  end
end