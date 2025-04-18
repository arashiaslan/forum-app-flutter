<?php

namespace App\Models;

use App\Models\Feed;
use Illuminate\Database\Eloquent\Model;

class Like extends Model
{
    protected $fillable = [
        'user_id',
        'feed_id',
    ];

    public function feed()
    {
        return $this->belongsTo(Feed::class);
    }
}
