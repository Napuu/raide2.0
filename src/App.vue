<template>
  <div id="app">
    <Form @onSubmit="handleSubmit"/>
    <Errors :errorsProp="errors" />
    <Answer :doneLoadingProp="doneLoading" :departureProp="departure" :arrivalProp="arrival" />
  </div>
</template>

<script>
			/* eslint-disable */
import Form from './components/Form.vue';
import Errors from './components/Errors.vue';
import Answer from './components/Answer.vue';

let stationMetadata = [];
fetch("https://rata.digitraffic.fi/api/v1/metadata/stations").then(resp => resp.json()).then((json) => {
  stationMetadata = json;

});

let nameToShortCode = (name) => {
	let foundEntry = stationMetadata.find(entry => {
		let n = name.toLowerCase();
		let t = entry.stationName.toLowerCase();
		return n === t || n + " asema" === t;
	});
  if (foundEntry === undefined) return undefined;
	else return foundEntry.stationShortCode;
};

export default {
  name: 'app',
  components: {
    Form,
    Errors,
    Answer
  },
  data() {
    return {
      errors: [],
      departure: {},
      arrival: {},
      doneLoading: false
    }
  },
  methods: {
    handleSubmit(data) {
      this.doneLoading = false;
      let departureStationShortCode = nameToShortCode(data.departure);
      let arrivalStationShortCode = nameToShortCode(data.arrival);
      fetch("https://rata.digitraffic.fi/api/v1/trains/latest/" + data.trainNumber).then((resp) => {
        return resp.json();
      }).then((json) => {
        this.errors = [];
        let trainNotFoundError = {trainNotFoundError: true, fatal: true, description: "Juna numero " + data.trainNumber + " ei pysähdy näillä asemilla"}
        if (json.length === 0) this.errors.push(trainNotFoundError);
        if (departureStationShortCode === undefined) this.errors.push({departureStationError: true, fatal: true, description: "Lähtöasemaa ei löytynyt", id: newID()});
        if (arrivalStationShortCode === undefined) this.errors.push({arrivalStationError: true, fatal: true, description: "Kohdeasemaa ei löytynyt", id: newID()});
        else {
          let departureEvents = json[0].timeTableRows.filter(entry => entry.stationShortCode === departureStationShortCode);
          let arrivalEvents = json[0].timeTableRows.filter(entry => entry.stationShortCode === arrivalStationShortCode);
          if (departureEvents.length === 0 || arrivalEvents.length === 0) this.errors.push(trainNotFoundError);
          else {
            let departure = departureEvents[departureEvents.length - 1];
            departure.stationName = data.departure;

            let arrival = arrivalEvents[0];
            arrival.stationName = data.arrival;
            if (new Date(departureEvents[0].scheduledTime).getTime() > new Date(arrivalEvents[0].scheduledTime).getTime()) {
              this.errors.push({wrongDirectionError: true, fatal: false, description: "Juna " + data.trainNumber + " kulkee vastakkaiseen suuntaan"})
              let t = departure;
              departure = arrival;
              arrival = t;
            } 
            this.departure = departure;
            this.arrival = arrival;
            this.doneLoading = true;
          }
        }
      }).catch((err) => {
        console.error(err);
      });
    }
  }
}

let newID = () => {
  return Math.floor(new Date().getTime() * Math.random());
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
