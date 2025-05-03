module ApplicationHelper
  include Pagy::Frontend

  def pagy_tailwind_nav(pagy)
    html = +%(<nav class="flex justify-center mt-6 text-sm">)
    html << pagy.series.map do |item|
      if item.is_a?(Integer)
        %(<a href="#{pagy_url_for(pagy, item)}" class="mx-1 px-3 py-1 border rounded hover:bg-gray-100">#{item}</a>)
      elsif item.is_a?(String) && item == pagy.page.to_s
        %(<span class="mx-1 px-3 py-1 border rounded bg-blue-600 text-white font-semibold">#{item}</span>)
      elsif item == :gap
        %(<span class="mx-1 px-3 py-1">…</span>)
      else
        item.to_s
      end
    end.join
    html << %(</nav>)
    html.html_safe
  end
end
