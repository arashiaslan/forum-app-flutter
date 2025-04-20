<?php

namespace App\Models;

use App\Models\Like;
use App\Models\User;
use App\Models\Comment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Feed extends Model
{
    protected $fillable = [
        'user_id',
        'content',
    ];

    protected $appends = ['liked'];

    public function user() : BelongsTo 
    {
        return $this->belongsTo(User::class);
    }

    public function likes() : HasMany 
    {
        return $this->hasMany(Like::class);
    }

    public function getLikedAttribute() : bool
    {
        return $this->likes()->where('feed_id', $this->id)->where('user_id', auth()->id())->exists();
    }

    public function comments() : HasMany 
    {
        return $this->hasMany(Comment::class);
    }
}
