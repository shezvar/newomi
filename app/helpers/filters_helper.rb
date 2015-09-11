module FiltersHelper
  def self.parse_name(name)
    name.gsub("-", " ")
  end

  def filter_section_generate(filter_params, generate_params, generate_links, hash_key)
    generate_params = generate_params.downcase.split
    current_params = params.clone
    generate_links.each do |link|
      if generate_params.include?(link)
        state = generate_params - [link]
        state.empty? ? current_params.delete(hash_key) : current_params[hash_key] = state.join(' ')
        concat link_to( FiltersHelper.parse_name(link), (current_params), { class: 'btn btn-success' } )
      else
        state = generate_params + [link]
        current_params[hash_key] = state.join(' ')
        concat link_to( FiltersHelper.parse_name(link), (current_params), { class: 'btn btn-default' } )
      end
    end
  end
end
