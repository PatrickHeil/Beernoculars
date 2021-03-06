import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import IndividualBrewery from '../components/IndividualBrewery.vue'
import BreweryList from '../components/BreweryList.vue'
import NewBreweryForm from '../views/NewBreweryForm'
import BeerAndReviews from '../components/BeerAndReviews'
import AddABeer from "../components/AddABeer"
import DeleteABeer from "../components/DeleteABeer"
import UpdateABrewery from "../components/UpdateABrewery"

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/brewery/:breweryId",
      name: "IndividualBrewery",
      component: IndividualBrewery,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/brewery",
      name: "breweries",
      component: BreweryList,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/newBreweryForm",
      name: "newBreweryForm",
      component: NewBreweryForm,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/brewery/:breweryId/:beerId",
      name: "beerAndReviews",
      component: BeerAndReviews,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/beer",
      name: "AddABeer",
      component: AddABeer,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/beer/:beerId",
      name: "DeleteABeer",
      component: DeleteABeer,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/updateABrewery",
      name: "UpdateABrewery",
      component: UpdateABrewery,
      meta: {
        requiresAuth: false
      }
    },
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
