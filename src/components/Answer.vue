<template>
  <div v-if="doneLoading" class="boxThing">
    <Event type="departure" :event="departure"/>
    <Event type="arrival" :event="arrival"/>
  </div>
</template>

<script>
  import Event from './Event.vue';
  export default {
    name: 'Answer',
    components: {
      Event,
    },
    props: {
      departureProp: {
        type: Object,
        required: true,
      },
      arrivalProp: {
        type: Object,
        required: true,
      },
      doneLoadingProp: {
        type: Boolean,
        required: true,
      }
    },
    data() {
      return {
        departure: this.departuresProp,
        arrival: this.arrivalProp,
        doneLoading: this.doneLoadingProp,
      };
    },
    watch: {
      departureProp(c) {
        this.departure = parseEvent(c);
      },
      arrivalProp(c) {
        this.arrival = parseEvent(c);
      },
      doneLoadingProp(c) {
        this.doneLoading = c;
      }
    },
  };
  let parseEvent = ev => {
    let time = ev.scheduledTime;
    let actual = false;
    if (ev.actualTime !== undefined) {
      time = ev.actualTime;
      actual = true;
    }
    time = new Date(time);
    time =
      (time.getHours() < 10 ? '0' + time.getHours() : time.getHours()) +
      ':' +
      (time.getMinutes() < 10 ? '0' + time.getMinutes() : time.getMinutes());
    return {
      track: ev.commercialTrack,
      time: time,
      actual: actual,
      stationName: firstToUpperCase(ev.stationName),
    };
  };
  let firstToUpperCase = s => {
    let al = s.toLowerCase();
    return al[0].toUpperCase() + al.substring(1);
  };
</script>

<style scoped>
.boxThing{
  padding: 10px;
  border: 1px solid rgba(0, 0, 0, 0.35);
  border-radius:  5px;
  margin: 4px;
}
</style>
