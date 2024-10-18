package com.mrahmed.quiztime.Activity

import android.content.Intent
import android.os.Bundle
import android.view.Window
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.mrahmed.quiztime.R
import com.mrahmed.quiztime.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val window: Window=this@MainActivity.window
        window.statusBarColor= ContextCompat.getColor(this@MainActivity, R.color.gray)

        binding.apply {
            bottomMenu.setItemSelected(R.id.home)
            bottomMenu.setOnItemSelectedListener {
                if (it==R.id.home){
                    startActivity(Intent(this@MainActivity, LeaderActivity::class.java))
                }
            }
        }
    }
    private fun questionList(): MutableList<QuestionMo>
}