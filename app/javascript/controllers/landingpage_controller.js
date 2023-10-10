import { Controller } from "@hotwired/stimulus"
import { GLTFLoader } from "https://ga.jspm.io/npm:three@0.157.0/examples/jsm/loaders/GLTFLoader.js"
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
    this.renderer.setSize(window.innerWidth * 0.75, window.innerHeight * 0.75);
    document.body.appendChild(this.renderer.domElement);

    const directionalLight = new THREE.DirectionalLight( 0xffffff, 3 ); // (colour, intensity)
    directionalLight.position.set(5,10,7.5)
    this.scene.add(directionalLight)

    this.camera.position.set(0,48,96)
    this.camera.lookAt(0,0,0);  
    
    // loading model
    loader.load('/medieval_fantasy_book.glb', (gltf) => {
      this.globalGLTF = gltf
      this.mixer = new THREE.AnimationMixer( gltf.scene );
      var action = this.mixer.clipAction( gltf.animations[0] );
      action.play();

      this.scene.add(gltf.scene);
      this.clock = new THREE.Clock();
      this.animate();
    }, undefined, function(error){
      console.error(error);
    })
    
    

  }
    animate() {
      requestAnimationFrame(this.animate.bind(this))
      var delta = this.clock.getDelta();
      if(this.mixer) this.mixer.update(delta)
      this.globalGLTF.scene.rotation.y = this.globalGLTF.scene.rotation. y + (delta  * 0.05)
      this.renderer.render(this.scene, this.camera)
    }
   

  
}
