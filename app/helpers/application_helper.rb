module ApplicationHelper
  def full_title(page_title = nil)
    [page_title, "My Test"].compact.join(" | ")
  end

  def panel_title(count, title)
    content_tag(:h2, count) + content_tag(:h4, title)
  end

  def set_id(index)
    params[:page].blank? ? index + 1 : ((params[:page]).to_i - 1) * 10 + index + 1
  end
end
