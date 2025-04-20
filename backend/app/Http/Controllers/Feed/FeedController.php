<?php

namespace App\Http\Controllers\Feed;

use App\Models\Feed;
use App\Models\Like;
use App\Models\Comment;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Http\Controllers\Controller;

class FeedController extends Controller
{

    public function index()
    {
        $feeds = Feed::with('user')->latest()->get();
        return response([
            'feeds' => $feeds
        ], 200);
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

    public function comment(Request $request, $feed_id)
    {
        $request->validate([
            'body' => 'required|string'
        ]);

        $comment = Comment::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id,
            'body' => $request->body
        ]);

        return response([
            'message' => 'success'
        ], 201);
    }

    public function getComments($feed_id)
    {
        $comments = Comment::with('feed')->with('user')->where('feed_id', $feed_id)->latest()->get();
        return response([
            'comments' => $comments
        ], 200);
    }


}
