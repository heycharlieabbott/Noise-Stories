using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class restarter : MonoBehaviour
{

    public Vector3 initpos;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

        Debug.Log(transform.position);

            
            if (Input.GetKey(KeyCode.Space)){
                
                
                transform.position = initpos;
                Debug.Log(initpos);
            }
            
            
        
        
    }
}
