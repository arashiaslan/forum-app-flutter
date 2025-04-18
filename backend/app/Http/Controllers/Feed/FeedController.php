<?php

namespace App\Http\Controllers\Feed;

use App\Models\Feed;
use App\Models\Like;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Http\Controllers\Controller;

class FeedController extends Controller
{

    public function index()
    {
        return auth()->user()->feeds()->get();
    }

    public function store(PostRequest $request)
    {
        $request->validated();
        
        auth()->user()->feeds()->create([
            'content' => $request->content
        ]);

        return response([
            'message' => 'Feed created successfully'
        ], 201);
    }

    public function likePost($feed_id)
    {
        $feed = Feed::whereId($feed_id)->first();

        if (!$feed) {
            return response([
                'message' => 'Feed not found'
            ], 404);
        }

        $unlike_post = Like::where('user_id', auth()->id())->where('feed_id', $feed_id)->delete();
        if ($unlike_post) {
            return response ([
                'message' => 'Unliked'
            ], 200);
        }

        $like_post = Like::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id
        ]);
        if ($like_post) {
            return response ([
                'message' => 'Liked'
            ], 200);
        }
    }
}
