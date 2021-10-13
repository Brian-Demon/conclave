class MarkdownRenderer
  def self.render(content)
    renderer = self.new
    renderer.render(content)
  end

  attr_reader :renderer, :markdown

  def initialize
    @renderer = Redcarpet::Render::HTML.new(renderer_options)
    @markdown = Redcarpet::Markdown.new(renderer, markdown_options)
  end

  def render(content)
    markdown.render(content)
  end

  def renderer_options
    { filter_html: true }
  end

  def markdown_options
    { 
      autolink: true, 
      tables: true, 
      strikethrough: true,
      fenced_code_blocks: true
    }
  end
end