# sort through each of the posts, generate post_num
# and then add that where placed in the permalink.
# Also updates redirect-from's as a shim
module Jekyll
  class PostNumPermalink < Generator
    safe true
    # this way it actually operates before any
    # possible dependant plugin
    priority :highest

    def generate(site)
      Jekyll.logger.info "Generating:", "post numbers and permalink via post_number_permalink.rb"
      Jekyll.logger.info "Generating:", "redirect-from shims via post_number_permalink.rb"
      post_count = 1
      # sort and then interate through posts
      site.posts.docs.sort_by{|p| p.data["data"]}.each do |item|
        # store the post number for use in post
        item.data["num"] = post_count
        post_count += 1
        # Append the redirect-from from the config
        if site.config['redirect-from']
          item.data['redirect_from'] = [item.data['redirect_from']] | [site.config['redirect-from'].dup]
          item.data['redirect_from'] = item.data['redirect_from'].flatten.compact
        end
        # update the permalink
        if not item.data['permalink']
          #if not site.config['permalink']
           # continue
          #end
          item.data['permalink'] = site.config['permalink'].dup
        end
        item.data['permalink'].gsub! ":post_num", item.data["num"].to_s
        # update any redirect-from's
        if item.data['redirect_from']
          item.data['redirect_from'].each do |redirects|
            redirects.gsub! ":post_num", item.data["num"].to_s
          end
        end
      end
    end
  end
end