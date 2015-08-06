using UnityEngine;
using System.Collections;

public class NoteController : MonoBehaviour {
	public float pitch = 1;
	private AudioSource _audioSource;
	public AudioClip note;
	
	void Start () {
		_audioSource = GetComponent<AudioSource>();
	}


	public void PlayNote(){
		_audioSource.PlayOneShot(note);
	}
}
