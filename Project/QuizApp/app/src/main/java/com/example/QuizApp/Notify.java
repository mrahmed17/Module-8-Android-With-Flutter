package com.example.QuizApp;

import android.content.Context;
import android.content.DialogInterface;

import androidx.appcompat.app.AlertDialog;

public class Notify {
    public static void exit (Context context){
        AlertDialog.Builder alerDialogBuilder = new AlertDialog.Builder(context);
        alerDialogBuilder.setTitle("Xác nhận để thoát !");
        alerDialogBuilder.setIcon(R.drawable.question);
        alerDialogBuilder.setMessage("Bạn có muốn thoát ?");
        alerDialogBuilder.setCancelable(false);

        alerDialogBuilder.setPositiveButton("Xác nhận", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int argl) {
                System.exit(1);
            }
        });

        alerDialogBuilder.setNegativeButton("Hủy bỏ", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });

        alerDialogBuilder.create().show();
    }
}
