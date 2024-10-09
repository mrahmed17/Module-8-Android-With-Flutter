package com.example.QuizApp;

import static com.example.QuizApp.R.*;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Map;

public class HomeActivity extends AppCompatActivity {

    TextView userName, btnLogout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(layout.activity_home);

        Intent intent = getIntent();
        String name = intent.getStringExtra("name");

        btnLogout = findViewById(id.btnLogout);
        userName = findViewById(id.tvUsernameHome);
        userName.setText("Xin chào " + name.toUpperCase());

        btnLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(HomeActivity.this);
                alertDialogBuilder.setTitle("Đăng xuất khỏi tài khoản !");
                alertDialogBuilder.setIcon(R.drawable.question);
                alertDialogBuilder.setMessage("Bạn chắc chứ ?");
                alertDialogBuilder.setCancelable(false);

                alertDialogBuilder.setPositiveButton("Xác nhận", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int argl) {
                        startActivity(new Intent(HomeActivity.this, LoginActivity.class));
                        finish();
                    }
                });

                alertDialogBuilder.setNegativeButton("Hủy bỏ", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });

                alertDialogBuilder.create().show();
            }
        });
    }

    @Override
    public void onBackPressed() {
        Notify.exit(HomeActivity.this);
    }

    private static final Map<Integer, CategoryData> VIEW_ID_TO_CATEGORY = new HashMap<>();

    static {
        VIEW_ID_TO_CATEGORY.put(id.ltw, new CategoryData(1, "ওয়েব প্রোগ্রামিং"));
        VIEW_ID_TO_CATEGORY.put(id.hdt, new CategoryData(2, "অবজেক্ট ওরিয়েন্টেড"));
        VIEW_ID_TO_CATEGORY.put(id.android, new CategoryData(3, "অ্যান্ড্রয়েড প্রোগ্রামিং"));
        VIEW_ID_TO_CATEGORY.put(id.web, new CategoryData(4, "নেটওয়ার্ক অ্যাডমিন"));
        VIEW_ID_TO_CATEGORY.put(id.hdh, new CategoryData(5, "অপারেটিং সিস্টেম"));
        VIEW_ID_TO_CATEGORY.put(id.sql, new CategoryData(6, "ডাটাবেস ম্যানেজমেন্ট সিস্টেম"));
    }

    // Helper class to store category data
    private static class CategoryData {
        int categoryId;
        String categoryName;

        CategoryData(int categoryId, String categoryName) {
            this.categoryId = categoryId;
            this.categoryName = categoryName;
        }
    }

    public void onClick(View v) {
        CategoryData categoryData = VIEW_ID_TO_CATEGORY.get(v.getId());

        if (categoryData != null) {
            Intent intent = new Intent(HomeActivity.this, StartActivity.class);
            intent.putExtra("categoryId", categoryData.categoryId);
            intent.putExtra("categoryName", categoryData.categoryName);
            startActivity(intent);
        } else {
            Toast.makeText(HomeActivity.this, "a", Toast.LENGTH_SHORT).show();
        }
    }


//    public void onClick(View v) {
//        Intent intent;
//        switch (v.getId()) {
//            case R.id.ltw:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",1);
//                intent.putExtra("categoryName","ওয়েব প্রোগ্রামিং");
//                startActivity(intent);
//                break;
//            case R.id.hdt:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",2);
//                intent.putExtra("categoryName","অবজেক্ট ওরিয়েন্টেড");
//                startActivity(intent);
//                break;
//            case R.id.android:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",3);
//                intent.putExtra("categoryName","অ্যান্ড্রয়েড প্রোগ্রামিং");
//                startActivity(intent);
//                break;
//            case R.id.web:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",4);
//                intent.putExtra("categoryName","নেটওয়ার্ক অ্যাডমিন");
//                startActivity(intent);
//                break;
//            case R.id.hdh:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",5);
//                intent.putExtra("categoryName","অপারেটিং সিস্টেম");
//                startActivity(intent);
//                break;
//            case R.id.sql:
//                intent = new Intent(HomeActivity.this, StartActivity.class);
//                intent.putExtra("categoryId",6);
//                intent.putExtra("categoryName","ডাটাবেস ম্যানেজমেন্ট সিস্টেম");
//                startActivity(intent);
//                break;
//
//            default:
//                Toast.makeText(HomeActivity.this, "a", Toast.LENGTH_SHORT).show();
//                break;
//        }
//    }
}