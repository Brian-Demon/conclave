class MarkdownRenderer
  class CodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      ::CodeRay.scan(code, language).div
    end
  end

  def self.render(content)
    renderer = self.new
    renderer.render(content)
  end

  attr_reader :renderer, :markdown

  def initialize
    @renderer = CodeRay.new(renderer_options)
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