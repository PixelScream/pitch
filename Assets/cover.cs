using UnityEngine;
using System.Collections;

public class cover : MonoBehaviour {
	private Renderer _renderer;

	// Use this for initialization
	void Start () {
		_renderer = GetComponent<Renderer>();
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Space)){
			_renderer.enabled = !_renderer.enabled;
		}
	}
}
