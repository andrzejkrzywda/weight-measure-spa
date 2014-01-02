require 'opal'
require 'jquery'
require 'opal-jquery'
require 'opal-haml'
require 'browser'


class Application
  def start
    user = User.new
    user.new_measure(Measure.new("29.12.2013", 89))
    user.new_measure(Measure.new("01.01.2013", 84.2))
    gui = Gui.new(user)
    gui.render
  end

end

class Gui

  def initialize(user)
    @user = user
  end

  def render
    source   = Element.find("#user-template").html()
    template = `Handlebars.compile(#{source})`
    data = @user.to_json
    html = template.call(data)
    puts html
    Element.find("main").html(html)
    #Element.find("#add-new-measure-button").on(:click) do
    #  date = Element.find("#new-date-field").value()
    #  weight = Element.find("#new-weight-field").value()
    #  @user.new_measure(Measure.new(date, weight))
    #end

    puts Browser::Window

    $document["main"] << div
  end
end

class User
  def initialize
    @measures = []
  end

  def new_measure(measure)
    @measures << measure
  end

  def to_json
    `{measures: [ {date: "29.12.2013", weight: 89}, {date: "01.01.2014", weight: 84.2} ]}`
  end

end

class Measure
  def initialize(date, weight)

  end
end

Document.ready? do
  Application.new.start
end
