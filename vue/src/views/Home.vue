<template class="template">
<body class="body" content="width=device-width, initial-scale=1.0">

   <div class="home">
     <div class="logo-photo">
        <img src="../images/beernoculars copy right.gif" alt="beernocular logo">
      </div>
    <header>
      
      <h1 id="home-h1">Beernoculars</h1>
    </header>    
    <img class="backgroundimage" src="../images/beer-2439237_960_720.webp" width="100%" height="100%" alt="homepage image">

    <div class="loading" v-if="isLoading">
      <img class="lazy" src="../images/9dc2a9af62e5d06ac0b9dce59e5b1d64.gif" />
    </div>
    <div class="breweryList">
      <brewery-list /> 
    </div>  
    <!--<div class="breweries">
      <button v-for="brewery in this.$store.state.breweries" v-bind:key="brewery.name" onclick="var displayBrewery = brewery.name">{{brewery.name}}</button>
    </div>-->
  </div>
  </body>
</template>

<script>
import BreweryList from '@/components/BreweryList';
export default {
  components: {BreweryList},
  name: "home",
  computed: {
    currentUser() {
      return this.$store.state.user;
    },
  },
  data() {
    return {
      isLoading: true
    }
  },
  created(){
    this.isLoading = false;
  }

};
</script>

<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Lobster&display=swap');

@import url('https://fonts.googleapis.com/css2?family=Lobster&family=Open+Sans&display=swap');
.logo-photo{
  /* object-fit:fill; */
  display:grid;
  grid-area: logoImage;

}
/* header {
  font-family: 'Lobster', cursive;
  grid-area: header;
  text-align: center;
} */
#home-h1 {
  text-align: center;
  color: black;
  background-color: goldenrod;
  font-family: 'Lobster', cursive;
  font-size: 84px;
  background: linear-gradient(
    to right,
    transparent,
    goldenrod,
    goldenrod,
    transparent);
    grid-area: h1;
}
.backgroundimage {
  min-height: 100%;
  min-width: 1024px;
  width:100%;
  height: auto;
  position: fixed;
  top: 0;
  left: 0;
  opacity: 0.8;
  z-index: -1;
  }
 div.home {
  display: grid;
  grid-template-columns: 300px 790px;
  grid-template-areas: 
    "logoImage h1"
    ". breweryList"
  ;
  grid-gap: 10px; 
  background: linear-gradient(
  to right,
  transparent,
  transparent,
  goldenrod,
    goldenrod); /*THIS MIGHT DO WHAT I WANT TO DO*/
 }
 .breweryList{
   cursor: pointer;
   background-color: goldenrod;
   opacity: 0.9;
   grid-area: breweryList;
   font-family: 'Open Sans', sans-serif;
   width: 100%;
   padding-left: 200px;
   border-radius: 25px;
   text-align: center;
   justify-content: center;
   height: 100%;
   top: 0;
   height: 100%;
   z-index: 2;
   background: linear-gradient(
    to right,
    transparent,
    transparent,
    goldenrod,
    goldenrod,
    goldenrod);
 }
div.loading {
  flex: 3;
  
}
/*.body{ Trying to make a yellow stripe on the page */
 
  /* background-color: goldenrod;
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;  
}

/* I think this can be deleted
img.lazy {
  position: absolute;
  top: 100px;
  left: 240px;
  z-index: 100;
} */

@media screen and (max-width: 480px) {
  body {
    grid-template-areas: 
      "header"
      "breweryList"
    ;
    grid-template-columns: auto;
  }
}
</style>