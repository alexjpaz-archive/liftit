import React from 'react';

import EntityRoute from './EntityRoute';

import Log from '../Log/index.jsx';

import Breadcrumb from './Breadcrumb.jsx';

class LogRoute extends EntityRoute {

  createNewEntity() {
    this.setState({
      isNew: true,
      date: new Date().toISOString().slice(0,10),
      type: 'log',
      weight: 100
    });
  }

  render() {
    if(!this.state) {
      return null;
    }
    return (
      <div>
        <Breadcrumb crumbs={[
            { title: 'Workbook', href: '/'},
            { title: 'Logs', href: '/logs' }
          ]}
          active={'New'}/>
        <Log item={this.state} onSubmit={(state) => {
          if(this.state.isNew) {
            this.state.isNew = undefined;
            this.db.post(this.state);
          } else {
            this.db.put(state);
          }
        }}/>
      </div>
    )
  }
};

module.exports = LogRoute;