<log-list>
<!-- Event card -->
<style>
.demo-card-event.mdl-card {
    width: 256px;
        height: 256px;
            background: #3E4EB8;
}
.demo-card-event > .mdl-card__actions {
    border-color: rgba(255, 255, 255, 0.2);
}
.demo-card-event > .mdl-card__title {
    align-items: flex-start;
}
.demo-card-event > .mdl-card__title > h4 {
    margin-top: 0;
}
.demo-card-event > .mdl-card__actions {
    display: flex;
        box-sizing:border-box;
            align-items: center;
}
.demo-card-event > .mdl-card__actions > .material-icons {
    padding-right: 10px;
}
.demo-card-event > .mdl-card__title,
.demo-card-event > .mdl-card__actions,
.demo-card-event > .mdl-card__actions > .mdl-button {
    color: #fff;
}
</style>

<div class="demo-card-event mdl-card mdl-shadow--2dp">
    <div class="mdl-card__title mdl-card--expand">
          <h4>
                  Featured event:<br>
                        May 24, 2016<br>
                              7-11pm
                                  </h4>
                                    </div>
                                      <div class="mdl-card__actions mdl-card--border">
                                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
                                                    Add to Calendar
                                                        </a>
                                                            <div class="mdl-layout-spacer"></div>
                                                                <i class="material-icons">event</i>
                                                                  </div>
</div>
  <table class="mdl-data-table mdl-js-data-table  mdl-shadow--2dp">
    <thead>
      <tr>
        <th>Date</th>
        <th>Lift</th>
        <th>Weight</th>
        <th>Reps</th>
      </tr>
    </thead>
    <tbody>
      <tr each={ l in logs } onclick={navigate(l.key)}>
        <td>{ l.date }</td>
        <td>{ l.lift }</td>
        <td>{ l.weight }</td>
        <td>{ l.reps }</td>
      </tr>
    </tbody>
  </table>
    <div class="mdl-card__actions mdl-card--border">
          <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
                  Get Started
                      </a>
                        </div>
  <div class="mdl-card__menu">
        <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
                <i class="material-icons">share</i>
                    </button>
                      </div>
  <a href class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent">
      Button
  </button>
  <a href='#/logs/new'>Add Log</a>
  <script>
    var self = this;

    var store = self.store = opts.api.store;

    self.navigate = function(key) {
      return function() {
        riot.route('/logs/'+key);
      };
    };

    self.logs = Object.keys(store.events).map(function(k){
      return store.events[k];
    }).filter(function(event) {
      return event.type === 'log';
    });

    store.on('digest', function(log) {
      self.update();
    });
  </script>
</log-list>
