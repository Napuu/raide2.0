<template>
  <div class="form-container">
    <b-form  v-on:submit.prevent="onSubmit" v-on:keydown.enter.prevent="onSubmit">
      <label for="departure">Lähtöasema</label>
      <b-form-input
        id="departure"
        v-model="form.departure"
        type="text"
        required
      ></b-form-input>


      <label for="arrival">Kohdeasema</label>
      <b-form-input
        id="arrival"
        v-model="form.arrival"
        type="text"
        required
      ></b-form-input>

      <label for="train-number">Junan numero</label>
      <b-form-input
        id="train-number"
        v-model="form.trainNumber"
        type="number"
        required
      ></b-form-input>

      <b-button type="submit" variant="primary">Hae tiedot</b-button>
    </b-form>
  </div>
</template>

<script>
  export default {
    name: 'Form',
    data() {
      return {
        form: {
          departure: '',
          arrival: '',
          trainNumber: null,
        },
      };
    },
    methods: {
      onSubmit(ev) {
        if (!this.form.departure || !this.form.arrival || !this.form.trainNumber) return false;
        ev.target.blur();
        this.$emit('onSubmit', this.form);
        return true;
      }
    }
  };

</script>

<style scoped>
form {
  padding: 10px;
  border: 1px solid rgba(0, 0, 0, 0.35);
  border-radius:  5px;
  margin: 4px;
}
label {
  margin: 0px;
}
input {
  margin-bottom: 10px;
}
</style>
