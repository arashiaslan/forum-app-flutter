<?php

namespace App\Models;

use App\Models\Like;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class Feed extends Model
{
    protected $fillable = [
        'user_id',
        'content',
    ];

    public function user() : BelongsTo 
    {
        return $this->belongsTo(User::class);
    }

    public function likes() : HasMany 
    {
        return $this->hasMany(Like::class);
    }
}
