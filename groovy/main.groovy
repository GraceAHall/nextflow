


class GroovyTut {
    static void main(String[] args) {
        
        def king = new Animal('King', 'Raaaaaa');
        println("$king.name says $king.sound");
        king.setSound('Reeee!');
        king.run();
        king.make_sound();

        println(king.toString());

    }
}