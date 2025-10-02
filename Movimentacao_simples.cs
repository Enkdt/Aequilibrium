using UnityEngine;
using UnityEngine.Rendering.Universal;

public class NewBehaviourScript : MonoBehaviour
{
    private Rigidbody2D Nickoll;
    private Animator Anim;
    private BoxCollider2D BoxCollider;
    [SerializeField] private LayerMask groundLayer;
    [SerializeField] private float speed;
    [SerializeField] private float jumpheight;

    private void Awake()
    {
        //pega referências para RigidBody e Animator do gameObject
        Nickoll = GetComponent<Rigidbody2D>();
        Anim = GetComponent<Animator>();
        BoxCollider = GetComponent<BoxCollider2D>();
    }

    private void Update()
    {
        float HorizontalInput = Input.GetAxis("Horizontal");

        Nickoll.velocity = new Vector2(HorizontalInput* speed,Nickoll.velocity.y);

        //Virar quando se mover direita/esquerda
        if (HorizontalInput > 0.01f)
            transform.localScale = Vector3.one;
        else if (HorizontalInput < -0.01f)
            transform.localScale = new Vector3(-1, 1, 1);


        if (Input.GetKey(KeyCode.Space) && isGrounded())
            jump();

        //Parâmetros de animação
        Anim.SetBool("Run", HorizontalInput != 0);
        Anim.SetBool("Grounded", isGrounded());
    }
    private void jump()
    {
        Nickoll.velocity = new Vector2(Nickoll.velocity.x, jumpheight);
        Anim.SetTrigger("Jump");
    }
    private void OnCollisionEnter2D(Collision2D collision)
    {
    }
    private bool isGrounded()
    {
        RaycastHit2D raycastHit = Physics2D.BoxCast(BoxCollider.bounds.center, BoxCollider.bounds.size, 0, Vector2.down, 0.1f, groundLayer);
        return raycastHit.collider != null;
    }
}
