import { Controller } from "@hotwired/stimulus"
import { GLTFLoader } from "https://ga.jspm.io/npm:three@0.157.0/examples/jsm/loaders/GLTFLoader.js"
// import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import * as THREE from "three";

// Connects to data-controller="landingpage"
export default class extends Controller {
  connect() {
    console.log("Hello stimulus")
    const loader = new GLTFLoader();

    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );

    this.renderer = new THREE.WebGLRenderer({alpha: true} );
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(this.renderer.domElement);

    // const light = new THREE.AmbientLight(0xffffff,4)  //colour, intensity
    // this.scene.add(light)
    const directionalLight = new THREE.DirectionalLight( 0xffffff, 3 );
    directionalLight.position.set(5,10,7.5)
    this.scene.add(directionalLight)

    this.camera.position.set(0,48,96)
    this.camera.lookAt(0,0,0);  

        // loading model
    loader.load('/medieval_fantasy_book.glb', (gltf) => {
      this.scene.add(gltf.scene);
      this.renderer.render(this.scene, this.camera);

    }, undefined, function(error){
      console.error(error);
    })

   


  }
}
