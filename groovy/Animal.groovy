
import groovy.transform.ToString;


@ToString(includeNames=true, includeFields=true)
class Animal {
    def name;
    def sound;
    
    // operates like static method
    def run() {
        println("$name runs!");
    }
    
    // operates like static method
    def make_sound() {
        println("$name says $sound");
    }

    // THIS IS A CONSTRUCTOR TO CONSTRUCT AN INSTANCE OF THIS BLUEPRINT
    Animal(name, sound) {
        this.name = name;        // this keyword = self in python
        this.sound = sound;
    }   
}