#!/usr/bin/env python3

"""Utiltiy which re-encodes a AV file into a web-friendly format"""

import json
import subprocess

from argparse import ArgumentParser
from pathlib import Path
from shlex import split


_CV_COPY = "-c:v copy"


def _handle_case(f: Path, audio_codec: str, disable_audio: bool, audio_codecs_to_ignore: tuple[str, ...] = ("aac",), video_args: str = _CV_COPY, audio_args: str = "-c:a aac -vbr 3", output_ext: str = ".mp4", additional_args: str = "-movflags +faststart") -> None:
    """Handles logic for creating an ffmpeg command

    Args:
        f (Path): The path to the source file to transcode
        audio_codec (str): The audio codec associated with `f`
        disable_audio (bool): indicates whether audio should be removed, this is the option the user sets via CLI
        audio_codecs_to_ignore (tuple[str, ...], optional): audio codecs to ignore, if applicable. Defaults to `("aac",)`.
        video_args (str, optional): the ffmpeg args to use for transcoding the video stream of `f`. Defaults to `"-c:v copy"`.
        audio_args (str, optional): the ffmpeg args to use for transcoding the audio stream of `f`. Defaults to `"-c:a aac -vbr 3"`.
        output_ext (str, optional): the file extension to use for the resulting output file. Defaults to `".mp4"`.
        additional_args (str, optional): any additional arguments to pass to ffmpeg. Optional, set `None` to disable. Defaults to `"-movflags +faststart"`.
    """
    l = [f"ffmpeg -y -i '{f}' {video_args}"]
    skip_video_encode = _CV_COPY == video_args

    if audio_codec:
        if disable_audio:
            l.append("-an")
        elif audio_codec not in audio_codecs_to_ignore:
            l.append(audio_args)
        elif skip_video_encode:
            print(f"both video & audio codecs for '{f}' are already web friendly, doing nothing")
            return
        else:
            l.append("-c:a copy")
    elif skip_video_encode:
        print(f"'{f}' does not have an audio track and is already web friendly, doing nothing")
        return

    if additional_args:
        l.append(additional_args)

    if (o := f.with_suffix(output_ext)).is_file():
        o = o.with_stem(f"{o.stem} 1")

    l.append(f"'{o}'")

    subprocess.run(split(" ".join(l)))


def _main() -> None:
    """Main driver, invoked when this file is run directly"""
    cli_parser = ArgumentParser(description="creates a web friendly video")
    cli_parser.add_argument('-n', action='store_true', help="do not include audio in the output video file")
    cli_parser.add_argument('videos', type=Path, nargs='+', help='the videos to process')
    args = cli_parser.parse_args()

    for p in args.videos:
        if not (streams := json.loads(subprocess.run(split(f"ffprobe -v error -show_entries stream=index,codec_type,codec_name -of json '{p}'"), capture_output=True).stdout.decode()).get("streams")):
            print(f"'{p}' is not an A/V file? Skipping")
            continue

        ac = vc = None
        for jo in streams:
            codec_type = jo["codec_type"]
            codec_name = jo["codec_name"]
            if not vc and codec_type == "video":
                vc = codec_name
            elif not ac and codec_type == "audio":
                ac = codec_name

            if ac and vc:
                break

        match vc:
            case None:
                print(f"did not detect video stream in '{p}', doing nothing!")
            case "h264":
                _handle_case(p, ac, args.n, additional_args=None)
            case "vp9":
                _handle_case(p, ac, args.n, ("vorbis", "opus"), audio_args="-c:a libopus -b:a 64k", output_ext=".webm", additional_args="-f webm")
            case _:
                _handle_case(p, ac, args.n, video_args="-c:v libx264 -preset slow -crf 28 -pix_fmt yuv420p")


if __name__ == "__main__":
    _main()
