var Cycle = require('../../../models/Cycle');
var DateUtils = require('../../../date');
var config = require('../../../config');
var Form = require('../../../form');

<cycle-schedule>
  <div class='panel panel-default'>
    <div class='panel-heading'>
      Max
    </div>
    <div class='panel-body'>
      <form onsubmit={submit}>
         <div class="form-group">
          <label>Date</label>
          <input class="form-control" type="date" name='date' value={ formatDateView(vm.date) } onchange={ model } required />
        </div>

        <div class="form-group" each={l in config.lifts}>
          <label>{ l }</label>
          <input class="form-control" type="number" name={l} value={vm[l]} onchange={ model } required />
        </div>

        <div class='form-group'>
          <label>repeat</label>
          <input class="form-control" type="number" name='repeat' value={ repeat } onchange={ updateRepeat } required />
        </div>

        <button class="btn btn-primary">
          Save Cycle Schedule
        </button>
      </form>
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Date</th>
            <th>Press</th>
            <th>Deadlift</th>
            <th>Bench</th>
            <th>Squat</th>
          </tr>
        </thead>
        <tbody>
          <tr each={ l in cycles } onclick={navigate(l.key)}>
            <td><a href='#/maxes/{ l.key }'>{ l.date }</a></td>
            <td>{ l.press }</td>
            <td>{ l.deadlift }</td>
            <td>{ l.bench }</td>
            <td>{ l.squat }</td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
  <script>
    var self = this;
    this.mixin('api');
    var store = self.api.store;
    self.config = store.config;

    self.repeat = 5;

    this.formatDateView = Form.formatDateView;

    this.generateScedule = function(cycle) {
      return Cycle.generateScedule({
        repeat: self.repeat,
        cycleIncrement: 30,
        cycle: cycle,
        config: config.get()
      });
    };

    this.updateRepeat = function(e) {
      var value = e.target.value;
      if(e.target.type === 'number') {
        value = +value;
      }

      self.repeat = value;
      self.cycles = self.generateScedule(self.vm);
      self.update();

    };

    this.model = function(e) {
      var value = e.target.value;

      if(e.target.type === 'number') {
        value = +value;
      }

      self.vm[e.target.name] = e.target.value;
      self.cycles = self.generateScedule(self.vm);
      self.update();
    };

    this.submit = function(form) {
      form.preventDefault();

      var today = DateUtils.create();

      if(self.vm.date < today) {
        alert("Start date must be set in the future!");
        return;
      }

      var events = [];

      events = events.concat(self.cycles);


      var futureCycles = Cycle.findAfter(self.vm.date).filter(function(cycle) {
        return cycle.date > today;
      });

      events = events.concat(futureCycles.map(function(cycle) {
        var clone = Object.assign({}, cycle)
        clone.disabled = true;
        return clone;
      }));

      store.trigger('updateEvents', events);

      window.history.back();
    };

    var route = riot.route.create();

    route('/cycles/schedule..', function() {
      var today = null;
      var query = riot.route.query();
      var templateCycle = null

      if(query.from) {
        var from = Cycle.get(query.from);
        templateCycle = Cycle.clone(from);
        if(from) {
          today = from.date;
        }
      } else {
        if(query.date) {
          today = DateUtils.create(query().date);
        } else {
          today = DateUtils.create();
        }
        templateCycle = new Cycle({
          date: today
        });
      }

      self.generateScedule(templateCycle);

      self.today = today;

      self.vm = templateCycle;

      self.update();
    });


  </script>
</cycle-schedule>
