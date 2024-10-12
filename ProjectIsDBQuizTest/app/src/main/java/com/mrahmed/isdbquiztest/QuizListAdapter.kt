package com.mrahmed.isdbquiztest

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.mrahmed.isdbquiztest.databinding.QuizItemRecyclerRowBinding

class QuizListAdapter(private val quizModelList: List<QuizModel>) : RecyclerView.Adapter<QuizListAdapter.MyViewHolder>() {

    class MyViewHolder(private val binding: QuizItemRecyclerRowBinding) : RecyclerView.ViewHolder(binding.root){
        fun bind(quizModel: QuizModel){
            binding.apply {
                quizTitleText.text = quizModel.title
                quizSubtitleText.text = quizModel.subtitle
                quizTimeText.text = quizModel.time + " min"
                root.setOnClickListener{
                    val intent = Intent(root.context, QuizActivity::class.java)
                    QuizActivity.questionModelList = quizModel.questionList
                    root.context.startActivity(intent)
                }
            }
        }
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): MyViewHolder {
       val binding = QuizItemRecyclerRowBinding.inflate(LayoutInflater.from(parent.context),parent,false)
        return MyViewHolder(binding)
    }

    override fun onBindViewHolder(
        holder: MyViewHolder,
        position: Int
    ) {
       holder.bind(quizModelList[position])
    }

    override fun getItemCount(): Int {
        return quizModelList.size
    }

}