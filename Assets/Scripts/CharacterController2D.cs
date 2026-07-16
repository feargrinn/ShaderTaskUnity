using System;
using UnityEngine;

public class CharacterController : MonoBehaviour
{
    private Rigidbody _rigidbody;
    private Vector3 _moveDirection;
    private const float MoveSpeed = 5f;

    private void Awake()
    {
        _rigidbody = GetComponent<Rigidbody>();
        _moveDirection = Vector3.zero;
    }

    private void Update()
    {
        float moveDirectionX = 0f;
        float moveDirectionY = 0f;

        if (Input.GetKey(KeyCode.W))
        {
            moveDirectionY = +1f;
        }
        if (Input.GetKey(KeyCode.S))
        {
            moveDirectionY = -1f;
        }
        if (Input.GetKey(KeyCode.A))
        {
            moveDirectionX = -1f;
        }
        if (Input.GetKey(KeyCode.D))
        {
            moveDirectionX = +1f;
        }
        
        _moveDirection = new Vector3(moveDirectionX, moveDirectionY).normalized;
    }

    private void FixedUpdate()
    {
        _rigidbody.linearVelocity = _moveDirection * MoveSpeed;
    }
}
