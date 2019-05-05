<template>
  <div>
    <div class="stationName">{{event.stationName}}</div>

    <div class="track">Raide {{event.track}}</div>
    <div class="time">
      <span v-if="event.actual">Toteutunut</span>
      <span v-else>Arvioitu</span>
      {{" "}}
      <span v-if="type==='departure'">lähtöaika</span>
      <span v-else>saapumisaika</span>
      {{event.time}}
    </div>
  </div>
</template>
<script>
  export default {
    name: 'Event',
    props: {
      event: {
        type: Object,
      },
      type: {
        type: String
      }
    },
  };
</script>

<style scoped>
  .stationName {
    font-weight: bold;
  } 
</style>
