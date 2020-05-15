HTMLWidgets.widget({

  name: 'fullcalendar',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        var calendar = new FullCalendar.Calendar(el, {
          plugins: [ 'dayGrid' , 'interaction'],

          // Sizing
          height: 'parent',

          // Object containing all events
          events: x.events,

          // Interactions with calendar
          selectable: x.selectable,

          dateClick: x.dateClick,

          select: x.select,

          //  Event Interactions
          eventClick: x.eventClick,

          eventLimit: x.eventLimit,
          eventLimitClick: x.eventLimitClick,

          editable: x.editable,
          rendering: x.rendering,

          // Non-standard properties
          resident: x.resident
        });

        calendar.render();
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
