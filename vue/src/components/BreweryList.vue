<template>
  <div content="width=device-width, initial-scale=1.0">
    <h1>List of Breweries</h1>
    <div class="breweries">
      <!-- <div class="loading" v-if="isLoading">
        <img src="../images/9dc2a9af62e5d06ac0b9dce59e5b1d64.gif" />
      </div> -->
      <div
        class="brewery"
        v-for="brewery in this.$store.state.breweries"
        v-bind:key="brewery.breweryId"
        v-on:click="viewBrewery(brewery.breweryId)">   
          <h3>{{brewery.breweryName}}</h3>
          <!--<address-detail 
          v-bind:passedBreweryAddressId = "brewery.breweryAddressId" />-->        
        <!--<router-link v-bind:to="{ name: 'Brewery', params: { id: brewery.id } }">
          {{ brewery.title }}
        </router-link>-->
      </div>
    </div>
  </div>
</template>

<script>
import BreweryService from '../services/BreweryService';
//import AddressDetail from '../components/AddressDetail';


export default {
  name:'brewery-list',
  //components: {AddressDetail},
  data() {
    return {
      //breweries: [],
     // isLoading: true
    };
  },
  created() {
    this.retrieveBreweries();
  },
  methods: {
    retrieveBreweries() {
      BreweryService.getBreweries().then(response => {
        this.$store.commit("SET_BREWERIES", response.data);
        this.isLoading = false;
      });
    },
    viewBrewery(breweryId){
      this.$router.push(`/brewery/${breweryId}`);
    }
  },

};
</script>

<style scoped>

</style>
