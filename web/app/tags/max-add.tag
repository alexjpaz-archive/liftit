<max-add>
  <div class='panel panel-default'>
    <div class='panel-heading'>
      Max
    </div>
    <div class='panel-body'>
      <form onsubmit={submit}>
         <div class="form-group">
          <label>Date</label>
          <input class="form-control" type="date" name='date' value={ vm.date } onchange={ model }>
        </div>

        <div class="form-group" each={l in lifts}>
          <label>{ l }</label>
          <input class="form-control" type="number" name={l} value={vm[l]} onchange={ model }>
        </div>

        <button class="btn btn-primary">
          Store Max
        </button>
      </form>
    </div>
  </div>

  <script>
    var self = this;

    this.mixin('api');

    var store = self.api.store;

    this.lifts = ['press','deadlift','bench','squat'];

    var route = riot.route.create();

    route('/maxes/*', function(key) {
      var event = store.events[key];

      if(!event) {
        event = {
          key: store.guid(),
          date: self.api.DateUtils.create(),
          type: 'max'
        }
      }

      self.vm = Object.assign({}, event);
      self.update();
    });


    this.model = function(e) {
      self.vm[e.target.name] = e.target.value;
    };

    this.submit = function(form) {
      form.preventDefault();
      store.trigger('addEvent', Object.assign({}, self.vm));
      riot.route('/maxes');
    };
  </script>
</max-add>
