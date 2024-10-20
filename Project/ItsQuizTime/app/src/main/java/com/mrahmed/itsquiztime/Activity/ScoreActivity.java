package com.mrahmed.itsquiztime.Activity;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.mrahmed.itsquiztime.databinding.ActivityScoreBinding;

public class ScoreActivity extends AppCompatActivity {
    private int score = 0;
    private ActivityScoreBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityScoreBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        score = getIntent().getIntExtra("score", 0);
        binding.scoreTxt.setText(String.valueOf(score));

        binding.backBtn.setOnClickListener(v -> {
            startActivity(new Intent(ScoreActivity.this, MainActivity.class));
            finish();
        });
    }
}
