using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Metronome : MonoBehaviour {
	public float speed = 5;
	//private Transform[] notes;
	List<GameObject> notes = new List<GameObject>();
	private float initiated;
	public Vector3 pos;
	public float t;
	public Transform wave;

	public Transform marker;
	public float markerTolerance = 2;

	public GameController _gameController;
	private bool looking = true;

	void Awake(){
		_gameController = GameObject.Find("Game Controller").GetComponent<GameController>();
		marker  = GameObject.FindGameObjectWithTag("Marker").transform;
	}
	// Use this for initialization
	void OnEnable () {
		notes = GameObject.FindGameObjectsWithTag("Note").ToList();	
		initiated = Time.time;
		pos = transform.position;
		wave.localScale = Vector3.zero;
		looking = true;
	}
	
	// Update is called once per frame
	void Update () {
		t = (Time.time - initiated) * speed;
		wave.localScale = Vector3.one * t * 2;
		if(looking){
			if(notes.Count != 0){

				for(int i = 0; i < notes.Count; i ++){
					if (Vector3.Distance(pos, notes[i].transform.position) < t){
						notes[i].GetComponent<NoteController>().PlayNote();
						print (t + ", " + notes[i].name + ", " + Vector3.Distance(pos, notes[i].transform.position));
						notes.RemoveAt(i);
					}
				}
				
			} else if (Vector3.Distance(pos, marker.position) < markerTolerance){
				print ("you win");
				_gameController.Win();
				looking = false;
			}
		}
	}
}
