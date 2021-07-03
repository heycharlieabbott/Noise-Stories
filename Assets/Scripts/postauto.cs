using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;


public class postauto : MonoBehaviour
{
    public Volume volume;
    Bloom bloom;

    public Material noiseworld;
    
    private float x = 0.17f;
    //private Vector4 tint = new Color(255f,255f,255f, 0f);

    private Vector4 noisetiles = new Vector4(1f,1f,1f,1f);

    public int gamemode;


 public static class FadeAudioSource {
    public static IEnumerator StartFade(Material material, float duration, float destination)
    {
        float currentTime = 0;
        float start = material.GetFloat("noisescale");

        while (currentTime < duration)
        {
            currentTime += Time.deltaTime;
            material.SetFloat("noisescale",Mathf.Lerp(start, destination, currentTime / duration));
            yield return null;
        }
        yield break;
    }

 }

    void Start()
    {
        

        if (volume.profile.TryGet<Bloom>(out bloom)){}
        
        noiseworld.SetFloat("noisescale",x);

        


        gamemode = 1;

        
    }

    // Update is called once per frame
    void Update()
    {

        

        if (Input.GetKeyDown(KeyCode.Space)){
            gamemode = gamemode %2;
            gamemode += 1;
            StartCoroutine(FadeAudioSource.StartFade(noiseworld, 3f,100f));
            noiseworld.SetFloat("noisescale",x);
            
        }

        if (gamemode ==1){

                if (Input.GetKey(KeyCode.UpArrow)){
                bloom.intensity.value += 0.3f;

                }

                if (Input.GetKey(KeyCode.DownArrow)){
                    bloom.intensity.value -= 0.3f;

                }

                if (Input.GetKey(KeyCode.RightArrow)){
                    x += 0.01f;
                    noiseworld.SetFloat("noisescale",x);
                    
                }

                if (Input.GetKey(KeyCode.LeftArrow)){
                    if(x >= 0){
                        x -= 0.01f;
                        noiseworld.SetFloat("noisescale",x);
                    }}


            }

        if (gamemode ==2){

            

            
                
                if (Input.GetKey(KeyCode.UpArrow)){
                    bloom.intensity.value += 0.3f;

                }

                if (Input.GetKey(KeyCode.DownArrow)){
                    bloom.intensity.value -= 0.3f;

                }

                if (Input.GetKey(KeyCode.RightArrow)){
                    noisetiles.x += 0.01f;
                    noiseworld.SetVector("noisetiles",noisetiles);
                    
                }

                if (Input.GetKey(KeyCode.LeftArrow)){
                    if(x >= 0){
                        x -= 0.01f;
                        noiseworld.SetFloat("noisescale",x);
                    }}

            }
           


            
        }



    }

