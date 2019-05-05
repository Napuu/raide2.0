<template>
<div class="answerbox">
    <b-alert class="alertThing" show v-for="error in errors" v-bind:key="error.id">{{error.description}}</b-alert>
</div>    
</template>

<script>

    export default {
        name: "Errors",
        props: {
            errorsProp: {
                type: Array,
                required: true
            }
        },
        data() {
            return {
                errors: this.errorsProp
            }
        },
        watch: {
            errorsProp(values) {
                this.errors = values
            }
        }
    }
</script>

<style scoped>
.alertThing {
  padding: 10px;
  border: 1px solid rgba(0, 0, 0, 0.35);
  border-radius:  5px;
  margin: 4px;
}
</style>
