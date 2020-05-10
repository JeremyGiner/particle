package particle.model;

/**
 * @author 
 */
enum abstract ParticleType(String) {
	//COMPONENT
	var matter;
	//var energy manipulator;
	var direction;
	var rotation;
	var creation;
	var fire;
	var space;


	//ENERGY MANIPULATION
	var burner;
	var generator;
	var redirect;
	var multiplexer;
	var multiplexer_V;
	var storage;


	//MATTER MANIPULATION
	var pusher;
	var fabricator;
	var spawner;
	var rotator;
	var mixer;
	var spliter;
	var sensor;
	var bounder;
	var propulsor;
	var wall_generator;
	var wheel;


	//OTHER
	var wall;
	var turret;
	var score;



	//TRANSITION
	var energy_echo;
	var fire_echo;

	//ENEMY
	var chaos;
}