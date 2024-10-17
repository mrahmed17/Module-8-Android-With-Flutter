package com.mrahmed.quiztime.Activity

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.mrahmed.quiztime.Domain.UserModel
import com.mrahmed.quiztime.R
import com.mrahmed.quiztime.databinding.ActivityLeaderBinding

class LeaderActivity : AppCompatActivity() {
    lateinit var bindiing: ActivityLeaderBinding
    private val leaderAdapter by lazy { LeaderAdapter() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        bindiing = ActivityLeaderBinding.inflate(layoutInflater)
        enableEdgeToEdge()
        setContentView(bindiing.root)

    }
    //you can get below list from your api service, this is a example list
    private fun loadData(): MutableList<UserModel>{
        val user: MutableList<UserModel> = mutableListOf()
        user.add(UserModel(1, "Raju","person1",4521))
        user.add(UserModel(2, "Ahmed","person2",4521))
        user.add(UserModel(3, "Rezvi","person3",4521))
        user.add(UserModel(4, "Nusrat","person4",4521))
        user.add(UserModel(5, "Towhid","person5",4521))
        user.add(UserModel(6, "Shabab","person6",4521))
        user.add(UserModel(7, "Shamima","person7",4521))
        user.add(UserModel(8, "Neyamul","person8",4521))
        user.add(UserModel(9, "Rafiqul","person9",4521))
        user.add(UserModel(10, "Sanaullah","person10",4521))
        user.add(UserModel(11, "Nirjash","person11",4521))
        user.add(UserModel(12, "Najmul","person12",4521))
        user.add(UserModel(13, "kutub","person13",4521))
        return users

    }

}