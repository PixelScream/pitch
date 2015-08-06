using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GameController : MonoBehaviour {
	public GameObject nome;
	public GameObject nomeReference;

	public Transform[] notes;
	public GameObject marker;
	private float boardSize;

	public bool won = false;
	public AudioClip winSound;
	private AudioSource _audioSource;
	public Text scoreText;
	private int score = 0;
	public ParticleSystem yay;
	public Transform ears;

	// Use this for initialization
	void Start () {
		nome = Instantiate(nomeReference, Vector3.zero, Quaternion.identity) as GameObject;
		nome.SetActive(false);
		boardSize = Camera.main.orthographicSize * 0.8f;
		_audioSource = GetComponent<AudioSource>();


		ShufflePieces();
	}
	
	// Update is called once per frame
	void Update () {
		if(!won){
			if(Input.GetMouseButtonDown(0)){
				nome.SetActive(false);
				marker.SetActive(false);
			}
			if(Input.GetMouseButtonUp(0)){

				Vector3 newPos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
				newPos.y = 0;
				nome.transform.position = newPos;

				nome.SetActive(true);

				ears.position = newPos;

			}
			if(Input.GetMouseButtonDown(1)){
				nome.SetActive(false);
				marker.SetActive(false);
			}
			if(Input.GetMouseButtonUp(1)){
				
				marker.SetActive(true);

				ears.position = marker.transform.position;
				
			}
		} else {
			if(Input.GetMouseButtonUp(0) || Input.GetMouseButtonUp(1) ){
				won = false;
				scoreText.enabled = false;
				ShufflePieces();
				marker.SetActive(true);
				yay.Stop();
			}
		}
	}

	public void ShufflePieces(){
		for(int i = 0; i < notes.Length; i ++){
			notes[i].position = GetRandomPos();
		}
		marker.transform.position  = GetRandomPos();

		ears.position = marker.transform.position;
	}

	Vector3 GetRandomPos(){
		return new Vector3((Random.value * boardSize * 2) - boardSize, 0, (Random.value * boardSize * 2) - boardSize);
	}

	public void Win(){
		score ++;
		scoreText.enabled = true;
		scoreText.text = score.ToString();
		won = true;
		_audioSource.PlayOneShot(winSound);
		yay.Play();
	}
}
