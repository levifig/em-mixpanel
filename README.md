# EM-Mixpanel

Async tracker for the Mixpanel API. It must run inside an [Eventmachine](https://github.com/eventmachine/eventmachine) reactor like the [Thin](https://github.com/macournoyer/thin) web server.

## Usage

    require 'em/mixpanel'
    tracker = EM::Mixpanel.new(ENV['MIXPANEL_TOKEN'])
    
    # This data point intentially doesn't have an IP
    tracker.track 'joined game', distinct_id: 'chrislloyd', world: 'minebnb'
    
    # For import events you need to set the time manually
    tracker.import '$signup', distinct_id: 'chrislloyd', time: 1321499371

### Rails
    
    # app/controllers/application_controller.rb
    
    def mixpanel
      @mixpanel ||= EM::Mixpanel.new(ENV['MIXPANEL_TOKEN'], ip: request.ip)
    end
    
    # app/controllers/photos_controller.rb
    
    def create
      # ...
      mixpanel.track 'photo uploaded', distinct_id: current_user.id.to_s
    end


## License

Copyright (C) 2011 David Newman & Chris Lloyd.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


    